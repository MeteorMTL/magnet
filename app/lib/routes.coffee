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
  action: "new"
  where: "client"
