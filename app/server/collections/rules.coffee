@roleOrganizer = new Roles.Role("organizer")
@roleParticipant = new Roles.Role("participant")

Roles.registerAction('userKeywords.insert', false, true)
UserKeywords.attachRoles "userKeywords"

roleParticipant.deny "userKeywords.insert", (userId, doc) ->
  userKeyword = UserKeywords.findOne
    userId: doc.userId
    keywordId: doc.keywordId
  if userKeyword then true else false

roleParticipant.deny "userKeywords.update", (userId, doc, fields, modifier) ->
  true
roleParticipant.deny "userKeywords.remove", (userId, doc) ->
  true
roleParticipant.allow "userKeywords.insert", (userId, doc) ->
  doc.authorId is userId and doc.userId is userId

Roles.registerAction('keywords.insert', false, true)
Keywords.attachRoles "keywords"
roleParticipant.deny "keywords.update", (userId, doc, fields, modifier) ->
  true
roleParticipant.deny "keywords.remove", (userId, doc) ->
  true
roleParticipant.allow "keywords.insert", (userId, doc) ->
  doc.authorId is userId

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

TeamPlayfields.allow
  insert: (userId, doc) ->
    true
  update: (userId, doc, fieldNames, modifier) ->
    true
  remove: (userId, doc) ->
    true
TeamPlayfields.deny
  insert: (userId, doc) ->
    false
  update: (userId, doc, fieldNames, modifier) ->
    false
  remove: (userId, doc) ->
    false

Playfields.allow
  insert: (userId, doc) ->
    true
  update: (userId, doc, fieldNames, modifier) ->
    true
  remove: (userId, doc) ->
    true
Playfields.deny
  insert: (userId, doc) ->
    false
  update: (userId, doc, fieldNames, modifier) ->
    false
  remove: (userId, doc) ->
    false
