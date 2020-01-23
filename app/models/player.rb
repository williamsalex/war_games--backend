require 'nokogiri'
require 'rest-client'
class Player < ApplicationRecord
    belongs_to :deck
    def self.get_players_info
        request = RestClient.get('https://www.baseball-reference.com/leaders/WAR_career.shtml',{})
        html = Nokogiri::HTML(request)
        string = html.to_s
        array = string.split("</td>")
        array.shift()
        array.pop()
        array2 = []
        array.each do |item|
            if item.include? "\n<td csk="
                array2 << item
            end
        end
        array4 = array2.map do |item|
            array = item.split("")
            array.delete_at(array.index(">"))
            array = array[0..array.index(">")].join("")
            array = array.split('href')
            array = array[1][2..-3]
            item = array
        end


        player_name_array = []
        array4[0...1].each do |player|
            player = 'https://www.baseball-reference.com'.concat(player)
            page = Nokogiri::HTML(RestClient.get(player, {}))
            war = page.to_s.split('Developed by Sean Smith of BaseballProjection.com">WAR</h4>')[1].split('<h4 class="poptip"')[0][4..-20]
            if !war.include? "p"
                each_player_hash = {}
                new_player_name = {}
                player_main_stats = page.css("div.p1").to_s
                player_secondary_stats = page.css("div.p2").to_s
                player_tertiary_stats = page.css("div.p3").to_s
                primary_player_type_indicator = player_main_stats.split('h4 class="poptip"')[2].split("data-tip")[1].split("h4")[0]
                if primary_player_type_indicator.include?("Wins")
                    player_type = "Pitcher"
                    pitcher_wins = player_main_stats.split('h4 class="poptip"')[2].split("data-tip")[1].split("h4")[1].split("</div>")[0][5..-6]
                    pitcher_losses = player_main_stats.split('Losses')[1].split('>L</h4>')[1].split("</div>")[0][4..-6]
                    earned_run_average = player_main_stats.split('ERA')[3].split('p>')[1][0..-3]
                    pitcher_strike_outs = player_tertiary_stats.split('Strikeouts')[1].split('</div>')[0][13..-6]
                    innings_pitched = player_tertiary_stats.split('Strikeouts')[0].split('</div>')[0][13..-6].split('<p>')[1]
                    pitching_saves = player_secondary_stats.split("Saves")[1].split("<p>")[1][0..-20]
                elsif primary_player_type_indicator.include?("At Bats")
                    player_type = "Hitter"
                    hitter_total_at_bats = player_main_stats.split('h4 class="poptip"')[2].split("data-tip")[1].split("h4>")[1].split("</div>")[0][4..-6]
                    hitter_total_hits = player_main_stats.split('Hits')[2].split("div")[0][20..-8]
                    hitter_total_batting_average = player_main_stats.split('Hits')[3].split('>BA</h4>')[1][4..-20]
                    hitter_total_homers = player_main_stats.split('Hits')[2].split('HR')[1].split('</div>')[0][9..-6]
                    hitter_total_runs = player_secondary_stats.split("Runs Scored")[1].split('</div>')[0].split('<p>')[1][0..-6]
                    hitter_total_rbi = player_secondary_stats.split("Runs Scored")[1].split('</div>')[1].split('RBI')[1][9..-6]
                    hitter_total_stolen_bases = player_secondary_stats.split("Runs Scored")[1].split('</div>')[2].split('SB')[1][9..-6] 
                    hitter_offensive_war = page.css("tr[data-stat='WAR_off']")
                    puts hitter_offensive_war
                      end
                player_name = page.css("h1[itemprop='name']").to_s
                player_image = page.css('img')[1].to_s.split('onerror')[0][10..-12]
                new_player_name[player_name.split("<")[1].split(">")[2]] = each_player_hash
                each_player_hash["player_type"] = player_type
                each_player_hash["war"] = war
                each_player_hash["image"] = player_image
                if player_type == "Pitcher"
                    each_player_hash["wins"] = pitcher_wins
                    each_player_hash["losses"] = pitcher_losses
                    each_player_hash["strikeouts"] = pitcher_strike_outs
                    each_player_hash["E.R.A."] = earned_run_average
                    each_player_hash["IP"] = innings_pitched
                    each_player_hash["saves"] = pitching_saves
                    
                elsif player_type == "Hitter"
                    each_player_hash["hits"] = hitter_total_hits
                    each_player_hash["avg"] = hitter_total_batting_average
                    each_player_hash["hr"] = hitter_total_homers
                    each_player_hash["runs"] = hitter_total_runs
                    each_player_hash["rbi"] = hitter_total_rbi
                    each_player_hash["sb"] = hitter_total_stolen_bases
                    each_player_hash["at bats"] = hitter_total_at_bats
                end
            end
                player_name_array << new_player_name
        end
        return player_name_array
    end
end
 