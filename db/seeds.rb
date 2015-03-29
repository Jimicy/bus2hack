jimmy = User.create(email: "jimmy@yahoo.com",
                    password: "hackwestern",
                    first_name: "jimmy",
                    last_name: "wang",
                    school: "McMaster University",
                    passport_expiry_date: Time.now,
                    confirmed_emails: [],
                    unconfirmed_emails: [],
                    bus_coordinator: "false")

delta_hacks = Hackathon.create(name: "deltaHacks",
                               date: Time.now-3.day)

hackwestern = Hackathon.create(name: "Hackwestern",
                               date: Time.now-1.day)

hackmit = Hackathon.create(name: "HackMIT",
                               date: Time.now+10.day)

hackthenorth = Hackathon.create(name: "HackTheNorth",
                               date: Time.now+10.day)

delta_hacks_bus = Bus.create(hackathon_id: delta_hacks.id,
                 school: "McMaster University")

hackwestern_bus = Bus.create(hackathon_id: hackwestern.id,
                 school: "Western University")

HackathonStatus.create(user_id: jimmy.id,
                       bus_id: hackwestern_bus.id,
                       hackathon_id: hackwestern.id,
                       status: "waitlisted")

HackathonStatus.create(user_id: jimmy.id,
                       bus_id: delta_hacks_bus.id,
                       hackathon_id: delta_hacks.id,
                       status: "accepted")