#!/usr/bin/env perl
#############################################################################
# $Id: ssl.pl,v 1.1.2.2 2007/06/14 09:21:17 gerv%gerv.net Exp $
#
# ***** BEGIN LICENSE BLOCK *****
# Version: MPL 1.1/GPL 2.0/LGPL 2.1
#
# The contents of this file are subject to the Mozilla Public License Version
# 1.1 (the "License"); you may not use this file except in compliance with
# the License. You may obtain a copy of the License at
# http://www.mozilla.org/MPL/
#
# Software distributed under the License is distributed on an "AS IS" basis,
# WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
# for the specific language governing rights and limitations under the
# License.
#
# The Original Code is PerLDAP.
#
# The Initial Developer of the Original Code is
# Netscape Communications Corporation.
# Portions created by the Initial Developer are Copyright (C) 2001
# the Initial Developer. All Rights Reserved.
#
# Contributor(s):
#   Clayton Donley
#   Rich Megginson <richm@stanfordalumni.org>
#
# Alternatively, the contents of this file may be used under the terms of
# either the GNU General Public License Version 2 or later (the "GPL"), or
# the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
# in which case the provisions of the GPL or the LGPL are applicable instead
# of those above. If you wish to allow use of your version of this file only
# under the terms of either the GPL or the LGPL, and not to allow others to
# use your version of this file under the terms of the MPL, indicate your
# decision by deleting the provisions above and replace them with the notice
# and other provisions required by the GPL or the LGPL. If you do not delete
# the provisions above, a recipient may use your version of this file under
# the terms of any one of the MPL, the GPL or the LGPL.
#
# ***** END LICENSE BLOCK *****

# DESCRIPTION
#    Test most (all?) of the LDAP::Mozilla::Conn methods. This code
#    needs to be rewritten to use the standard test harness in Perl...

use Getopt::Std;			# To parse command line arguments.
use Mozilla::LDAP::Conn;		# Main "OO" layer for LDAP
use Mozilla::LDAP::Utils;		# LULU, utilities.
use Mozilla::LDAP::API;

use strict;
no strict "vars";


# Uncomment for somewhat more verbose messages from core modules
#$LDAP_DEBUG = 1;


#################################################################################
# Configurations, modify these as needed.
#
$BASE	= "dc=example,dc=com";
$PEOPLE	= "ou=people";
$UID	= "scarter";


#################################################################################
# Constants, shouldn't have to edit these...
#
$APPNAM	= "ssl.pl";
$USAGE	= "$APPNAM -b base -h host -D bind -w pswd -P cert -N certname -W keypassword -Z";


#################################################################################
# Check arguments, and configure some parameters accordingly..
#
if (!getopts('b:h:D:p:s:w:P:N:W:Z'))
{
   print "usage: $APPNAM $USAGE\n";
   exit;
}
%ld = Mozilla::LDAP::Utils::ldapArgs(undef, $BASE);
$BASE = $ld{"base"};
Mozilla::LDAP::Utils::userCredentials(\%ld) unless $opt_n;
