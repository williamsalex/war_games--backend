# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create(username: "holder")
deck1 = Deck.create(user: user1)


Player.get_players_info.each do |player|
    begin
        name = player.keys[0]
        war = player[name]["war"]
        image = player[name]["image"]
    #     if player_type == "Pitcher"
    #   wins =  player[name]["wins"]
    #     losses = player[name]["losses"]
    #    strikeouts =  player[name]["strikeouts"]
    #        ERA = player[name]["E.R.A."]
    #       IP = player[name]["IP"]
    #     saves = player[name]["saves"]
        new_player = Player.create(name: name, war: war, deck_id: 1)
    rescue
        puts player
    end
end