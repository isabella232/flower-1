#!/usr/bin/env ruby

require 'rubygems'
require 'eventmachine'
require 'hallon'
require 'hallon-openal'

class EmClient < EventMachine::Connection
  def initialize
    init_session
  end

  def receive_data(data)
    data.split("\n").reverse.each do |msg|
      puts "want to play #{msg.inspect}"
      case msg
      when /\.(mp3|wav)$/
        play_file(msg)
      when "pause"
        pause_song
      when "play"
        resume_song
      else
        play_song!(Hallon::Track.new(msg))
      end
    end
  end

  # Hallon
  # ------------------------------
  def play_song!(song)
    player.play!(song)
  end

  def pause_song
    player.pause
  end

  def resume_song
    player.play
  end

  private

  def play_file(file_name)
    system("afplay", File.expand_path(File.join(__FILE__, "..", "..", "extras", file_name)))
  end

  def init_session
    @@hallon_session ||= hallon_session!
  end

  def player
    @@player ||= Hallon::Player.new(Hallon::OpenAL)
  end

  def hallon_session!
    if appkey = IO.read(Flower::Config.spotify_appkey) rescue nil
      session = Hallon::Session.initialize(appkey)
      session.login(Flower::Config.spotify_username, Flower::Config.spotify_password)
      scrobbler = Hallon::Scrobbler.new(:lastfm)
      scrobbler.credentials = [Flower::Config.lastfm_username, Flower::Config.lastfm_password]
      scrobbler.enabled = true
    else
      puts("Warning: No spotify_appkey.key found. Get yours here: https://developer.spotify.com/technologies/libspotify/#application-keys")
    end
  end
end
