Meteor.publish "Photos", ->
  Photos.find()

Meteor.publish "ProfilePhoto", ->
  Photos.find userId: @userId

Meteor.publish "UserData", ->
  Meteor.users.find {},
    fields:
      "profile.name": 1
      emails: 1
      services: 1
      lastAnnounced: 1
      "profile.facebook": 1
      "profile.twitter": 1
      "profile.firstName": 1
      "profile.linkedin": 1

Meteor.publish "Teams", ->
  Teams.find()

Meteor.publish "Messages", (teamId) ->
  Messages.find teamId: teamId

Meteor.publish "LatestMessages", ->
  Messages.find {},
    sort:
      createdAt: -1
    limit: 1

Meteor.publish "Commitments", ->
  Commitments.find()

Meteor.publish 'Keywords', ->
  Keywords.find()
Meteor.publish 'UserKeywords', ->
  userKeywords = UserKeywords.find()
  keywords = Keywords.find().fetch()
  self = @
  _.each(keywords, (keyword) ->
    userKeywords = UserKeywords.find(keywordId: keyword._id)
    Counts.publish(self, "userKeywordsByKeyword-" + keyword._id, userKeywords)
  )
  userKeywords
Meteor.publish 'TeamKeywords', ->
  teamKeywords = TeamKeywords.find()
  keywords = Keywords.find().fetch()
  self = @
  _.each(keywords, (keyword) ->
    userKeywords = UserKeywords.find(keywordId: keyword._id)
    Counts.publish(self, "userKeywordsByKeyword-" + keyword._id, userKeywords)
  )
  teamKeywords
Meteor.publish 'UserKeywordsUser', ->
  UserKeywords.find(userId: @userId)
Meteor.publish 'TeamKeywordsTeam', (teamId) ->
  TeamKeywords.find(teamId: teamId)

Meteor.publish 'Playfields', ->
  Playfields.find()

Meteor.publish 'TeamPlayfields', ->
  TeamPlayfields.find()
