use strict;
no warnings qw(redefine);
use vars qw/$r $m %session/;

# {{{ sub FindGroupsWithAccess

=head2 FindGroupsWithAccess (Object => RT::Object, ARGSRef => hash ref)

Finds user-defined groups that have any kind of permissions on a given object. Returns two hashes, both keyed by group name: one with a list of group objects and one with a list of the rights for the group. Used in the GroupRights.html screens.

=cut

sub FindGroupsWithAccess {
     my $Object = shift;
     my $ARGSref = shift;

     my %ARGS = %$ARGSref;

     my %group_obj_hash = ();
     my %group_rights_hash = ();

# First, find the groups that have any kind of access to the queue # by directly querying the ACL table:
     my $ACLObj = new RT::ACL($session{'CurrentUser'});

     $ACLObj->LimitToObject($Object);
     $ACLObj->Limit(FIELD => 'PrincipalType',
                                        OPERATOR => '=',
                                        VALUE => 'Group',
                                );
     $ACLObj->OrderBy(FIELD=>'ObjectId');
     $ACLObj->OrderBy(FIELD=>'RightName');
    while (my $right = $ACLObj->Next()) {
                my $group = $right->PrincipalObj->Object;
                next unless $group->Domain eq 'UserDefined';
                $group_obj_hash{$group->Name} = $right->PrincipalObj;
                if ($group_rights_hash{$group->Name}) {
                        push @{$group_rights_hash{$group->Name}}, $right;
                } else {
                        $group_rights_hash{$group->Name} = [ $right ];
                        }
                }

#
# If the user specified a group search, look for matching # groups and add them to the cache (if they're not already there).
#
    if (length $ARGS{'GroupString'}) {
                my $Groups = new RT::Groups($session{'CurrentUser'});
                $Groups->LimitToUserDefinedGroups();
                $Groups->Limit(FIELD => $ARGS{'GroupField'},
                                        VALUE => $ARGS{'GroupString'},
                                        OPERATOR => $ARGS{'GroupOp'});
                $Groups->OrderBy(FIELD=>'Name');
                while (my $Group = $Groups->Next()) {
                        unless ($group_rights_hash{$Group->Name}) {
                                $group_obj_hash{$Group->Name} = $Group->PrincipalObj;
                                $group_rights_hash{$Group->Name} = [ ];
                        }
                }
    }

    return (\%group_obj_hash, \%group_rights_hash); }
# }}}

1;
