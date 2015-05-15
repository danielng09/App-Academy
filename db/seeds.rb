User.destroy_all
Band.destroy_all
Album.destroy_all
Track.destroy_all

User.create!(email: "admin@gmail.com", password: "admin1")

Band.create!(name: "Death Cab for Cutie")
Album.create!(name: "Kintsugi", band_id: 1, record_type: "live")
Track.create!(name: "Black Sun", album_id: 1, track_type: "regular", lyrics: "There is whisky in the water / And there is death upon the vine")
Track.create!(name: "No Room In Frame", album_id: 1, track_type: "regular", lyrics: "I don't know where to begin / There's too many things that I can't remember")
Track.create!(name: "The Ghosts of Beverly Drive", album_id: 1, track_type: "regular", lyrics: "If only you'd have known me before the accident")
Track.create!(name: "Little Wanderer", album_id: 1, track_type: "bonus", lyrics: "You sent a photo out your window of Tokyo Told me you were doing fine")
