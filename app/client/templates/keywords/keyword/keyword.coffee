Template.Keyword.events {
  'click .keyword': (event, template) ->
    event.preventDefault()
    keywordId = template.data._id
    userKeyword = UserKeywords.findOne(userId: Meteor.userId(), keywordId: keywordId)
    if userKeyword
      UserKeywords.update
        _id: userKeyword._id
      ,
        $set:
          keywordId: userKeyword.keywordId
    else
      UserKeywords.insert
        userId: Meteor.userId()
        keywordId: keywordId
        authorId: Meteor.userId()

    setTimeout(() ->
      Router.go('KeywordEdit', _id: keywordId)
    ,
      500)
}

Template.Keyword.helpers {
  userKeywordsCount: ->
    Counts.get('userKeywordsByKeyword-' + @_id)
}

# Keyword: Lifecycle Hooks
Template.Keyword.created = ->

Template.Keyword.rendered = ->

Template.Keyword.destroyed = ->
