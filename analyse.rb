require 'nil/file'
require 'nil/console'

class ChampionStats
  attr_reader :name, :games, :victories

  def initialize(name)
    @name = name
    @kills = 0
    @deaths = 0
    @assists = 0
    @victories = 0
    @games = 0
  end

  def gather(kills, deaths, assists, victorious)
    @kills += kills
    @deaths += deaths
    @assists += assists
    if victorious
      @victories += 1
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

def loadChampionData(path)
  lines = Nil.readLines(path)
  if lines == nil
    raise 'Unable to open stats file'
  end
  champions = {}
  lines.each do |line|
    pattern = /([A-Za-z\. ]+?) (\d+) (\d+) (\d+) (V|D)/
    match = line.match(pattern)
    if match == nil
      raise "Invalid line: #{line}"
    end
    championName = match[1]
    kills = match[2].to_i
    deaths = match[3].to_i
    assists = match[4].to_i
    victorious = match[5] == 'V'
    champion = champions[championName]
    if champion == nil
      champion = ChampionStats.new(championName)
      champions[championName] = champion
    end
    champion.gather(kills, deaths, assists, victorious)
  end
  champions = champions.values.sort do |x, y|
    x.name <=> y.name
  end
  return champions
end

def decimal(input)
  return sprintf('%.1f', input)
end

def printStatistics(champions)
  table = [
    [
      'Champion',
      'Wins/losses',
      'Win ratio',
      'K/D/A',
      'K/D',
      'K+A/D',
    ]
  ]
  champions.each do |champion|
    row = [
      champion.name,
      "#{champion.victories} - #{champion.games - champion.victories}",
      decimal(champion.winRatio * 100) + '%',
      "#{decimal(champion.killsPerGame)}/#{decimal(champion.deathsPerGame)}/#{decimal(champion.assistsPerGame)}",
      decimal(champion.killsPerDeath),
      decimal(champion.killsAssistsPerDeath),
    ]
    table << row
  end
  Nil.printTable(table)
end

champions = loadChampionData('../input/data')
printStatistics(champions)
