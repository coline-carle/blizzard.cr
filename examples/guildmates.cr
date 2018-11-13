require "../src/blizzard"

def main
  if ARGV.size != 3
    puts "usage: guildmates.cr region realm-slug guildname"
    return
  end

  unless ENV.has_key? "BLIZZARD_CLIENT_ID"
    puts "BLIZZARD_CLIENT_ID env variable need to be set"
    return
  end
  unless ENV.has_key? "BLIZZARD_CLIENT_SECRET"
    puts "BLIZZARD_CLIENT_SECRET env variable need to be set"
    return
  end

  region = ARGV[0]
  realm = ARGV[1]
  guild = ARGV[2]

  oauth = Blizzard::OAuth2.new("us", ENV["BLIZZARD_CLIENT_ID"], ENV["BLIZZARD_CLIENT_SECRET"])
  token = oauth.get_access_token_using_client_credentials
  client = Blizzard::Client.new(region.downcase, token)

  guild = client.wow_guild(realm, guild, fields: ["members"])

  members = guild.members
  if members.is_a? Array
    members.each do |member|
      puts "#{member.character.name}-#{member.character.realm} (rank #{member.rank})"
    end
  end
end

main
