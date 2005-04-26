package Catalyst::Plugin::Observe;

use strict;
use base 'Class::Publisher';

our $VERSION='0.01';

{
    my @observable = qw[
        dispatch
        finalize
        finalize_body
        finalize_cookies
        finalize_error
        finalize_headers
        forward
        prepare
        prepare_action
        prepare_body
        prepare_connection
        prepare_cookies
        prepare_headers
        prepare_parameters
        prepare_path
        prepare_request
        prepare_uploads
    ];

    no strict 'refs';

    for my $observe ( @observable ) {

        eval sprintf( <<'', ($observe) x 3 );
        sub %s {
            my $c = shift;
            $c->notify_subscribers( %s, @_ );
            return $c->NEXT::%s(@_);
        }

    }
}

1;

__END__

=head1 NAME

Catalyst::Plugin::Observe - Observe Engine Events

=head1 SYNOPSIS

    use Catalyst qw[Observe];

    MyApp->add_subscriber( 'prepare_path', \&observer );

    sub observer {
        my ( $c, $event, @args ) = @_;
        printf( "observed : %s\n", $event );
    }


=head1 DESCRIPTION

Observe Engine events.

=head1 OBSERVABLE EVENTS

=over 4

=item dispatch

=item finalize

=item finalize_body

=item finalize_cookies

=item finalize_error

=item finalize_headers

=item forward

=item prepare

=item prepare_action

=item prepare_body

=item prepare_connection

=item prepare_cookies

=item prepare_headers

=item prepare_parameters

=item prepare_path

=item prepare_request

=item prepare_uploads

=back

=head1 SEE ALSO

L<Class::Publisher>, L<Catalyst::Dispatch>, L<Catalyst::Engine>.

=head1 AUTHOR

Christian Hansen, C<ch@ngmedia.com>

=head1 LICENSE

This library is free software . You can redistribute it and/or modify it under
the same terms as perl itself.

=cut
