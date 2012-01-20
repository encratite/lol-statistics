class ChampionStats
  attr_reader :name, :games, :victories, :defeats

  def initialize(name)
    @name = name
    @kills = 0
    @deaths = 0
    @assists = 0
    @victories = 0
    @defeats = 0
    @games = 0
  end

  def gather(kills, deaths, assists, victorious)
    @kills += kills
    @deaths += deaths
    @assists += assists
    if victorious
      @victories += 1
    else
      @defeats += 1
    end
    @games += 1
  end

  def killsPerGame
    return @kills.to_f / @games
  end

  def deathsPerGame
    return @deaths.to_f / @games
  end

  def assistsPerGame
    return @assists.to_f / @games
  end

  def winRatio
    return @victories.to_f / @games
  end

  def killsPerDeath
    return @kills.to_f / @deaths
  end

  def killsAssistsPerDeath
    return (@kills + @assists).to_f / @deaths
  end
end
