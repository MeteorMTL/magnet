Router.configure
  layoutTemplate: "MasterLayout"
  loadingTemplate: "Loading"
  notFoundTemplate: "NotFound"

Router.before(->
  @subscribe("pages")
  @subscribe("Playfields")
  @next()
)

Router.onBeforeAction (->
  unless Meteor.user()
    @render "AccessDenied"
  else
    @next()
),
  only: [ "profile" ]

Router.route "/login", (->
  @layout ReactiveTemplates.get("outAdminLayout")
  @render ReactiveTemplates.get("login")
),
  name: "login"

Router.route "/", ->
  this.redirect('Teams');

Router.route "words",
  name: "Words"
  controller: "WordsController"
  action: "action"
  where: "client"

Router.route "photos",
  name: "Photos"
  controller: "PhotosController"
  action: "action"
  where: "client"

Router.route "commitments",
  name: "Commitments"
  controller: "CommitmentsController"
  action: "action"
  where: "client"

Router.route "people",
  name: "People"
  controller: "PeopleController"
  action: "action"
  where: "client"

Router.route "profile",
  name: "profile"
  controller: "ProfileController"
  action: "action"
  where: "client"

Router.route "teams",
  name: "Teams"
  controller: "TeamsController"
  action: "list"
  where: "client"

Router.route "t/new",
  name: "TeamNew"
  controller: "TeamsController"
  action: "new"
  where: "client"

Router.route "t/:_id/edit",
  name: "TeamEdit"
  controller: "TeamsController"
  action: "edit"
  where: "client"

Router.route "t/:_id",
  name: "TeamShow"
  controller: "TeamShowController"
  action: "action"
  where: "client"


Router.route 'keywords',
  name: 'Keywords'
  controller: 'KeywordsController'
  action: 'list'
  where: 'client'

Router.route 'k/:_id',
  name: 'KeywordEdit'
  controller: 'KeywordsController'
  action: 'edit'
  where: 'client'

Router.route 'playfields',
  name: 'playfields'
  controller: 'PlayfieldsController'
  action: 'action'
  where: 'client'

Router.route 'team_playfields',
  name: 'teamPlayfields'
  controller: 'TeamPlayfieldsController'
  action: 'action'
  where: 'client'
