Template.registerHelper("active", function (path) {
  if (Router.current().url === path) {
    return "active";
  } else {
    return "";
  }
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
  return Roles.userHasRole(user._id, 'organizer');
});
