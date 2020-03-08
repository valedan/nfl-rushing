player_data = JSON.parse(File.read('./db/rushing.json'))
PlayerDataImporter.call(player_data)