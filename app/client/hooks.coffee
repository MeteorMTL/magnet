AutoForm.addHooks null,
  onError: (name, error, template) ->
    console.error name + " error:", error

AutoForm.addHooks null,
  onSubmit: (insertDoc, updateDoc, currentDoc) ->
    if @.formId.lastIndexOf("newTeamKeyword-" + insertDoc.teamId, 0) is 0
      this.event.preventDefault()
      keyword = Keywords.findOne
        name: insertDoc.name
      unless keyword
        keywordId = Keywords.insert
          name: insertDoc.name
          authorId: Meteor.userId()
        keyword = Keywords.findOne
          _id: keywordId
      if keyword
        TeamKeywords.insert
          teamId: insertDoc.teamId
          keywordId: keyword._id
          authorId: Meteor.userId()
    false

AutoForm.hooks
  activePlayfield:
    onSubmit: (insertDoc, updateDoc, currentDoc) ->
      this.event.preventDefault()
      Session.set("activePlayfield", insertDoc.playfieldId)
      false
  teamNew:
    before:
      insert: (doc) ->
        doc.authorId ?= Meteor.userId()
        doc
    onSuccess: (formType, result) ->
      Router.go("Teams")
  newKeyword:
    onSubmit: (insertDoc, updateDoc, currentDoc) ->
      this.event.preventDefault()
      keyword = Keywords.findOne
        name: insertDoc.name
      unless keyword
        keywordId = Keywords.insert
          name: insertDoc.name
          authorId: Meteor.userId()
        keyword = Keywords.findOne
          _id: keywordId
      if keyword
        UserKeywords.insert
          userId: Meteor.userId()
          keywordId: keyword._id
          authorId: Meteor.userId()
      false
