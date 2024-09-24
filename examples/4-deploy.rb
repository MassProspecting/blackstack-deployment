require_relative '../lib/blackstack-deployment.rb'
require_relative '../config.rb'

l = BlackStack::LocalLogger.new('deploy-examples.log')

begin
=begin
    # pull source code
    l.logs "Pulling source code... "
    BlackStack::Deployment.source( :master,
        bash_script_filename: './deploy.pampa',
        logger: l
    )
    l.done
=end
    # run migrations
    l.logs "Running migrations... "
    BlackStack::Deployment.migrations( :master,
        logger: l
    )
    l.done
rescue => e
    l.error(e)
end