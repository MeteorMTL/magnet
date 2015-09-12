@roleOrganizer = new Roles.Role("organizer")
@roleParticipant = new Roles.Role("participant")

Roles.registerAction('userKeywords.insert', false, true)
UserKeywords.attachRoles "userKeywords"
roleParticipant.deny "userKeywords.insert", (userId, doc) ->
  userKeyword = UserKeywords.findOne(userId: userId)
  if userKeyword then true else false
roleParticipant.deny "userKeywords.update", (userId, doc, fields, modifier) ->
  true
roleParticipant.deny "userKeywords.remove", (userId, doc) ->
  true
roleParticipant.allow "userKeywords.insert", (userId, doc) ->
  doc.authorId is userId and doc.userId is userId


Charts.allow
  insert: (userId, doc) ->
    true
  update: (userId, doc, fieldNames, modifier) ->
    true
  remove: (userId, doc) ->
    true
Charts.deny
  insert: (userId, doc) ->
    false
  update: (userId, doc, fieldNames, modifier) ->
    false
  remove: (userId, doc) ->
    false

Commitments.allow
  insert: (userId, doc) ->
    true
  update: (userId, doc, fieldNames, modifier) ->
    true
  remove: (userId, doc) ->
    true
Commitments.deny
  insert: (userId, doc) ->
    false
  update: (userId, doc, fieldNames, modifier) ->
    false
  remove: (userId, doc) ->
    false

Likes.allow
  insert: (userId, doc) ->
    true
  update: (userId, doc, fieldNames, modifier) ->
    false
  remove: (userId, doc) ->
    false
Likes.deny
  insert: (userId, doc) ->
    false
  update: (userId, doc, fieldNames, modifier) ->
    true
  remove: (userId, doc) ->
    false

Messages.allow
  insert: (userId, doc) ->
    true
  update: (userId, doc, fieldNames, modifier) ->
    true
  remove: (userId, doc) ->
    true
Messages.deny
  insert: (userId, doc) ->
    false
  update: (userId, doc, fieldNames, modifier) ->
    false
  remove: (userId, doc) ->
    false

Photos.allow
  insert: (userId, doc) ->
    true
  update: (userId, doc, fieldNames, modifier) ->
    true
  remove: (userId, doc) ->
    true
Photos.deny
  insert: (userId, doc) ->
    false
  update: (userId, doc, fieldNames, modifier) ->
    false
  remove: (userId, doc) ->
    false

Reactions.allow
  insert: (userId, doc) ->
    true
  update: (userId, doc, fieldNames, modifier) ->
    true
  remove: (userId, doc) ->
    true
Reactions.deny
  insert: (userId, doc) ->
    false
  update: (userId, doc, fieldNames, modifier) ->
    false
  remove: (userId, doc) ->
    false

Teams.allow
  insert: (userId, doc) ->
    true
  update: (userId, doc, fieldNames, modifier) ->
    true
  remove: (userId, doc) ->
    true
Teams.deny
  insert: (userId, doc) ->
    false
  update: (userId, doc, fieldNames, modifier) ->
    false
  remove: (userId, doc) ->
    false

Topics.allow
  insert: (userId, doc) ->
    true
  update: (userId, doc, fieldNames, modifier) ->
    true
  remove: (userId, doc) ->
    true
Topics.deny
  insert: (userId, doc) ->
    false
  update: (userId, doc, fieldNames, modifier) ->
    false
  remove: (userId, doc) ->
    false

Meteor.users.allow
  insert: (userId, doc) ->
    true
  update: (userId, doc, fieldNames, modifier) ->
    true
  remove: (userId, doc) ->
    true
Meteor.users.deny
  insert: (userId, doc) ->
    false
  update: (userId, doc, fieldNames, modifier) ->
    false
  remove: (userId, doc) ->
    false

Votes.allow
  insert: (userId, doc) ->
    true
  update: (userId, doc, fieldNames, modifier) ->
    true
  remove: (userId, doc) ->
    true
Votes.deny
  insert: (userId, doc) ->
    false
  update: (userId, doc, fieldNames, modifier) ->
    false
  remove: (userId, doc) ->
    false

Interests.allow
  insert: (userId, doc) ->
    true
  update: (userId, doc, fieldNames, modifier) ->
    true
  remove: (userId, doc) ->
    true
Interests.deny
  insert: (userId, doc) ->
    false
  update: (userId, doc, fieldNames, modifier) ->
    false
  remove: (userId, doc) ->
    false

CommunityKeywords.allow
  insert: (userId, doc) ->
    true
  update: (userId, doc, fieldNames, modifier) ->
    true
  remove: (userId, doc) ->
    true

CommunityKeywords.deny
  insert: (userId, doc) ->
    false
  update: (userId, doc, fieldNames, modifier) ->
    false
  remove: (userId, doc) ->
    false

UserKeywords.allow
  insert: (userId, doc) ->
    true
  update: (userId, doc, fieldNames, modifier) ->
    true
  remove: (userId, doc) ->
    true

UserKeywords.deny
  insert: (userId, doc) ->
    false
  update: (userId, doc, fieldNames, modifier) ->
    false
  remove: (userId, doc) ->
    false

TeamKeywords.allow
  insert: (userId, doc) ->
    true
  update: (userId, doc, fieldNames, modifier) ->
    true
  remove: (userId, doc) ->
    true

TeamKeywords.deny
  insert: (userId, doc) ->
    false
  update: (userId, doc, fieldNames, modifier) ->
    false
  remove: (userId, doc) ->
    false

EventKeywords.allow
  insert: (userId, doc) ->
    true
  update: (userId, doc, fieldNames, modifier) ->
    true
  remove: (userId, doc) ->
    true

EventKeywords.deny
  insert: (userId, doc) ->
    false
  update: (userId, doc, fieldNames, modifier) ->
    false
  remove: (userId, doc) ->
    false

TeamPlayfields.allow
  insert: (userId, doc) ->
    false
  update: (userId, doc, fieldNames, modifier) ->
    false
  remove: (userId, doc) ->
    false
TeamPlayfields.deny
  insert: (userId, doc) ->
    true
  update: (userId, doc, fieldNames, modifier) ->
    true
  remove: (userId, doc) ->
    true

Playfields.allow
  insert: (userId, doc) ->
    false
  update: (userId, doc, fieldNames, modifier) ->
    false
  remove: (userId, doc) ->
    false
Playfields.deny
  insert: (userId, doc) ->
    true
  update: (userId, doc, fieldNames, modifier) ->
    true
  remove: (userId, doc) ->
    true
