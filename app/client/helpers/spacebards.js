Template.registerHelper("active", function (path) {
  return Router.current().url === path ? "active" : "";
});

Template.registerHelper("debug", function (optionalValue) {
  if (typeof console !== "undefined" || typeof console.log !== "undefined") {
    console.log("Current Context");
    console.log("====================");
    console.log(this);
    if (optionalValue) {
      console.log("Value");
      console.log("====================");
      console.log(optionalValue);
    }
    return "";
  }
  alert(this);
  if (optionalValue) {
    alert(optionalValue);
  }
  return "";
});

Template.registerHelper("isInRole", function(role) {
  role = typeof role !== 'undefined' ? role : 'organizer';
  return Meteor.user() ? Roles.userHasRole(Meteor.user()._id, role):"";
});
