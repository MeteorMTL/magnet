/*****************************************************************************/
/* Navigation: Event Handlers */
/*****************************************************************************/
Template.Navigation.events({
  'click #at-nav-button': function(event) {
    if (Meteor.user()) {
      AccountsTemplates.logout();
    } else {
      Router.go('login');
    }
  }
});

/*****************************************************************************/
/* Navigation: Helpers */
/*****************************************************************************/
Template.Navigation.helpers({
  myName: function (){
    // if a user exists use the profile name, if that is no good use the email if all fails use 'My'
    return Meteor.user() ? 
             typeof(Meteor.user().profile.name) !== 'undefined' && Meteor.user().profile.name !== null  && Meteor.user().profile.name.length > 0 ? 
	       Meteor.user().profile.name + "'s" : 
             typeof(Meteor.user().profile.firstName) !== 'undefined' && Meteor.user().profile.firstName !== null  && Meteor.user().profile.firstName.length > 0 ? 
	       Meteor.user().profile.firstName + "'s"  /* linkedin */: 
	     typeof(Meteor.user().emails) !== 'undefined' && Meteor.user().emails[0].address !== null  &&  Meteor.user().emails[0].address.length > 1 ?
	       Meteor.user().emails[0].address  + "'s":  /* sometimes the service data is absent... */ 
	     typeof(Meteor.user().services.github) !== 'undefined' ? "github" : 
	     typeof(Meteor.user().services.facebook) !== 'undefined' ? "facebook" : 
	     typeof(Meteor.user().services.linkedin) !== 'undefined' ? "linkedin" : 
	     typeof(Meteor.user().services.google) !== 'undefined' ? "google" : 
	     typeof(Meteor.user().services.twitter) !== 'undefined' ? "twitter" 
	     : "My"
           : "My";

  }
});

/*****************************************************************************/
/* Navigation: Lifecycle Hooks */
/*****************************************************************************/
Template.Navigation.created = function () {
};

Template.Navigation.rendered = function () {
  $(".button-collapse").sideNav({
    menuWidth: 300,
    edge: "left",
    closeOnClick: true
  });
};

Template.Navigation.destroyed = function () {
};
