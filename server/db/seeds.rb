# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Drop all data so seeding doesn't fail
# NOTE: this does not reset id sequences
Milestone.destroy_all
Responsibility.destroy_all
Violation.destroy_all
SportBan.destroy_all
DoctorAppointment.destroy_all
DiaryEntry.destroy_all
Stay.destroy_all
User.destroy_all # drop user fails if still referenced by stay
GroupActivity.destroy_all
MilestoneType.destroy_all
ResponsibilityType.destroy_all

############################################################################
# Users
############################################################################
luke = User.new(
  email: 'luke.skywalker@example.com',
  password: 'devdev',
  full_name: 'Luke Skywalker',
  display_name: 'Luke'
)
luke.save!

yoda = User.new(
  email: 'yoda@example.com',
  password: 'devdev',
  full_name: 'Yoda'
)
yoda.save!

han = User.new(
  email: 'han.solo@example.com',
  password: 'devdev',
  full_name: 'Han Solo'
)
han.save!

chewie = User.new(
  email: 'chewie@example.com',
  password: 'devdev',
  full_name: 'Chewbacca',
  display_name: 'Chewie',
  birthday: Date.new(2020, 5, 25)
)
chewie.save!

leia = User.new(
  email: 'leia.organa@example.com',
  password: 'devdev',
  full_name: 'Leia Organa',
  display_name: 'Princess Leia'
)
leia.save!

############################################################################
# Stays
############################################################################
stays = Stay.create([
  {
    patient: luke,
    start_at: DateTime.new(2020, 2, 22),
    end_at: DateTime.new(2020, 3, 17),
    godparent: han,
    room_nr: 2
  },
  {
    patient: luke,
    start_at: DateTime.new(2020, 4, 5),
    end_at: nil,
    godparent: chewie,
    room_nr: 2
  },
  {
    patient: han,
    start_at: DateTime.new(2019, 11, 29),
    end_at: DateTime.new(2020, 4, 1)
  },
  {
    patient: chewie,
    start_at: DateTime.new(2020, 2, 5),
    end_at: DateTime.new(2020, 4, 1),
    godparent: han,
    room_nr: 2
  }
])

############################################################################
# Group Activities
############################################################################
activities = GroupActivity.create([
  {
    title: 'Breakfast',
    start_at: DateTime.new(2020, 5, 1, 8, 0),
    end_at: DateTime.new(2020, 5, 1, 9, 0),
    repeat_every: 24 * 60 * 60 * 1000, # every day
  },
  {
    title: 'Lunch',
    start_at: DateTime.new(2020, 5, 1, 12, 0),
    end_at: DateTime.new(2020, 5, 1, 13, 0),
    repeat_every: 24 * 60 * 60 * 1000, # every day
  },
  {
    title: 'Dinner',
    start_at: DateTime.new(2020, 5, 1, 6, 30),
    end_at: DateTime.new(2020, 5, 1, 7, 30),
    repeat_every: 24 * 60 * 60 * 1000, # every day
  },
  {
    title: 'Gym',
    start_at: DateTime.new(2020, 5, 4, 9, 0),
    end_at: DateTime.new(2020, 5, 4, 12, 0),
    repeat_every: 7 * 24 * 60 * 60 * 1000, # every week
    repeat_until: DateTime.new(2021, 1, 1)
  },
  {
    title: 'Grand Opening of the Hyperloop',
    start_at: DateTime.new(2021, 3, 1, 12, 0),
    end_at: DateTime.new(2021, 3, 4, 14, 0)
  }
])

############################################################################
# Milestone Types
############################################################################
mt1 = MilestoneType.new(
  name: 'Travel to Dagobah',
  major: false,
  previous_milestone_type: nil
)
mt1.save!

mt2 = MilestoneType.new(
  name: 'Find Yoda',
  major: false,
  previous_milestone_type: mt1
)
mt2.save!

mt3 = MilestoneType.new(
  name: 'Feel the Force',
  major: true,
  previous_milestone_type: mt2
)
mt3.save!

mt4 = MilestoneType.new(
  name: 'Fight your shadows',
  major: false,
  previous_milestone_type: mt3
)
mt4.save!

mt5 = MilestoneType.new(
  name: 'Levitate a stone',
  major: false,
  previous_milestone_type: mt4
)
mt5.save!

mt6 = MilestoneType.new(
  name: 'Levitate X-Wing Fighter',
  major: true,
  previous_milestone_type: mt5
)
mt6.save!

############################################################################
# Milestones
############################################################################
milestones = Milestone.create([
  {
    stay: stays.first,
    milestone_type: mt1
  },
  {
    stay: stays.first,
    milestone_type: mt2
  },
  {
    stay: stays.first,
    milestone_type: mt3
  },
  {
    stay: stays.first,
    milestone_type: mt4
  },
  {
    stay: stays[1],
    milestone_type: mt1
  },
  {
    stay: stays[1],
    milestone_type: mt2
  }
])

############################################################################
# Responsibility Types
############################################################################
resTypes = ResponsibilityType.create([
  {
    name: 'Kitchen Responsible'
  },
  {
    name: 'Weekend Responsible'
  }
])

############################################################################
# Responsibilities
############################################################################
resps = Responsibility.create([
  {
    responsibility_type: resTypes.first,
    stay: stays.first,
    start_at: DateTime.new(2020, 2, 22)
  }
])

############################################################################
# Violations
############################################################################
violations = Violation.create([
  {
    stay: stays[0]
  },
  {
    stay: stays[0]
  },
  {
    stay: stays[2]
  }
])

############################################################################
# Sport Bans
############################################################################
sport_bans = SportBan.create([
  {
    stay: stays[1],
    negate: true,
    created_at: DateTime.new(2020, 3, 23)
  },
  {
    stay: stays[1],
    created_at: DateTime.new(2020, 2, 22)
  },
  {
    stay: stays[2],
    created_at: DateTime.new(2020, 5, 10)
  }
])

############################################################################
# Doctor Appointments
############################################################################
da = DoctorAppointment.create([
  {
    stay: stays[2],
    start_at: DateTime.new(2019, 11, 29, 14, 00),
    end_at: DateTime.new(2019, 11, 29, 15, 00)
  }
])

############################################################################
# Diary Entries
############################################################################
de = DiaryEntry.create([
  {
    stay: stays[2],
    content: 'Such a great day!'
  }
])
