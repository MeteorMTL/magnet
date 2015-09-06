Template.TeamKeywords.events {
  'submit form': (event, template) ->
    event.preventDefault()
    name = event.target.name
    keyword = Keywords.findOne({name: name.value})
    if keyword
      teamKeyword = TeamKeywords.findOne({teamId: template.data._id, keywordId: keyword._id})
      if not teamKeyword
        TeamKeywords.insert
          teamId: template.data._id
          keywordId: keyword._id
          authorId: Meteor.userId()
    else
      keywordId = Keywords.insert
        name: name.value
        authorId: Meteor.userId()
      TeamKeywords.insert
        teamId: template.data._id
        keywordId: keywordId
        authorId: Meteor.userId()
    name.value = ""
}

Template.TeamKeywords.helpers {
  keywords: ->
    console.log("template.currentData", Template.currentData())
    teamKeywords = TeamKeywords.find({teamId: Template.currentData()._id}).fetch()
    keywordIds = _.pluck(teamKeywords, "keywordId")
    console.log("teamKeywords", teamKeywords)
    Keywords.find(
      _id:
        $in: keywordIds
    ,
      sort:
        name: -1
    )
  }
