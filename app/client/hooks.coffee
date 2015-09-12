AutoForm.addHooks null,
  onError: (name, error, template) ->
    console.error name + " error:", error

AutoForm.hooks
  userKeywords:
    before:
      insert: (doc) ->
        doc.authorId ?= Meteor.userId()
        doc
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
    before:
      insert: (doc) ->
        doc.authorId ?= Meteor.userId()
        doc
  newTeamKeyword:
    before:
      insert: (doc) ->
        console.log("before insert", doc)
        doc.authorId ?= Meteor.userId()
        doc
    after:
      insert: (error, result) ->
        console.log("after insert", error, result)
        unless error
          console.log("result", result)
    onSubmit: (insertDoc, updateDoc, currentDoc) ->
      this.event.preventDefault()
      console.log("onSubmit", insertDoc)
      keyword = Keywords.findOne
        name: insertDoc.name
      unless keyword
        keywordId = Keywords.insert
          name: insertDoc.name
          authorId: Meteor.userId()
        keyword = Keywords.findOne
          _id: keywordId
      if keyword
        console.log("teamId", insertDoc.teamId)
        console.log("keywordId", keyword._id)
        TeamKeywords.insert
          teamId: insertDoc.teamId
          keywordId: keyword._id
          authorId: Meteor.userId()
      false
