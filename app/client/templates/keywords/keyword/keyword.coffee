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
          keywordId: userKeyword.keywordId # Set to same value to trigger update timestamp update
    else
      UserKeywords.insert
        userId: Meteor.userId()
        keywordId: keywordId
        authorId: Meteor.userId()
    setTimeout(() ->
      Router.go('KeywordEdit', _id: keywordId)
    ,
      200)
}

Template.Keyword.helpers {
  userKeywordsCount: ->
    Counts.get('userKeywordsByKeyword-' + @_id)
}
