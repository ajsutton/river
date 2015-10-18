TODO
====

Most things really, but here's some good next step type things.

Custom Fields
-------------
 * Improve the administration UI
 * Allow order of fields to be specified
 * Actually enforce the required option in custom fields
 * Support select box field types
 * Support reference field types (e.g. Person having a "Parent" field that points to another Person)
 * Support uniqueness constraints on fields (e.g. can't have two people with same value for name)

People
------
 * Remove first_name and last_name predefined fields and treat all fields a custom.

Views
-----
 * Complete tests for: View filters should apply to custom fields (currently can really only apply to first_name and last_name).
 * Order by name (or specify order)

Authentication/Authorisation
----------------------------
 * Ability to invite someone to join a church (as opposed to every sign up creating a new church)
 * Integrate with Azure Active Directory for authentication in production mode
 * Support multiple authentication sources in production mode (need a really good interface for this)
