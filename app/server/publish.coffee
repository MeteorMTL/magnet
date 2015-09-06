Meteor.publish "Votes", ->
  Votes.find()

Meteor.publish "Topics", ->
  Topics.find()

Meteor.publish "Topic", (topicId) ->
  Topics.find _id: topicId

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


Meteor.publish "Likes", (teamId) ->
  Likes.find teamId: teamId

Meteor.publish "TopicTeams", (topicId) ->
  votes = Votes.find(topicId: topicId).fetch()
  userIds = _.pluck(votes, "userId")
  commitments = Commitments.find(userId:
    $in: userIds
  ).fetch()
  teamIds = _.pluck(commitments, "teamId")
  Teams.find _id:
    $in: teamIds

Meteor.publish "TeamTopics", ->

  #console.log(TeamTopics.find().fetch());
  TeamTopics.find()

Meteor.publish "Commitments", ->
  Commitments.find()

Meteor.publish "Reactions", ->
  Reactions.find()

Meteor.publish "Charts", ->
  Charts.find()

Meteor.publish 'interests', ->
  Interests.find()

Meteor.publish 'Keywords', ->
  Keywords.find()
Meteor.publish 'UserKeywords', ->
  userKeywords = UserKeywords.find()
  keywords = Keywords.find().fetch()
  self = @
  _.each(keywords, (keyword) ->
    votes = UserKeywords.find(keywordId: keyword._id)
    Counts.publish(self, "userKeywordsByKeyword-" + keyword._id, votes)
  )
  userKeywords
Meteor.publish 'TeamKeywords', ->
  teamKeywords = TeamKeywords.find()
  keywords = Keywords.find().fetch()
  self = @
  _.each(keywords, (keyword) ->
    votes = UserKeywords.find(keywordId: keyword._id)
    Counts.publish(self, "userKeywordsByKeyword-" + keyword._id, votes)
  )
  teamKeywords

  TeamKeywords.find()
Meteor.publish 'UserKeywordsUser', ->
  UserKeywords.find(userId: @userId)
Meteor.publish 'TeamKeywordsTeam', (teamId) ->
  TeamKeywords.find(teamId: teamId)
