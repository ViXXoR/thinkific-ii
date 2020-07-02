## Notes
*Please do not supply your name or email address in this document. We're doing our best to remain unbiased.*  
I'd like to mention that I chose to use Rails for the API, and I have never used Rails before. So there are possibly some best practices that I may have missed, and I apologize if that is the case.  
This has been the most fun I've had with a take home assignment, so thank you so very much for that! :)  
  
You can find the code for the API here: https://github.com/ViXXoR/thinkific-ii
You can find the code for the front-end here: https://github.com/ViXXoR/thinkific-fe
### Date
July 2nd, 2020
### Location of deployed application
Front end: https://cloud.mmrlivingstone.com/thinkific/
API: https://cloud.mmrlivingstone.com/thinkific-api/
### Time spent
Roughly 7 hours.
### Assumptions made
I assumed that I should have basic error checking, and appropriate responses to the user.  
I also made the decision to add an "authenticate" endpoint that takes the same arguments as register (`{ 'email': 'your@email.com', 'password': 'secret' }`) and allows a user to re-use their account.  
I assumed that it was okay to have issues when the integers got too large, like with `999999999999999999999999`, as it exceeds the sqlite3 limit of 8 bytes.
### Shortcuts/Compromises made
I didn't do any unit testing in the application. It wasn't asked for but I would have liked to try unit tests in Rails.
### Stretch goals attempted
#### Built a SPA for the Front-end
The SPA was done in Vue, and deployed to https://cloud.mmrlivingstone.com/thinkific/
#### Deployed the API and Front-end
I deployed the API and front-end to my personal VPS. The API was deployed with Docker, and the front-end was simplyed pushed after being built.
#### Started OAuth Authentication
I was going to build in OAuth authentication, as it seemed straight forward using the omniauth gem as I had already been using the devise gem. However, once I realized I was going to have to create developer accounts for most of the services, the amount of time and effort required became a little too much. I will outline the steps I would have performed had I had more time (this is based on some examples I had found).
- Create a migration for required OAuth columns in the Users table
```
rails g migration AddOAuthColumnsToUsers provider uid
rake db:migrate
```
- Register callbacks with OAuth service providers
- Update `config/initializers/devise.rb` to include `config.omniauth` entries for all providers
- Update `models/user.rb` with a `def self.from_omniauth(auth)` method to handle extraction after authentication
- Update `config/routes.rb` with the callback routes for omniauth callbacks
- Create a class that inherits from `Devise::OmniauthCallbacksController` to handle to OAuth callbacks

There is likely more work I would have had to do, but I wanted it to be clear that I had done the research.
### Instructions to run assignment locally
#### API
With Ruby (2.6.6p146) and Rails (6.0.3.2) installed:
- Run the migrations with `rake db:migrate`
- Serve the app with `rails s`
#### Front-end
With Node/NPM installed:
- cd into the application directory
- Update `main.js`, changing
```
const base = axios.create({
  //baseURL: 'http://localhost:3000',
  baseURL: 'https://cloud.mmrlivingstone.com/thinkific-api',
})
```
to
```
const base = axios.create({
  baseURL: 'http://localhost:3000',
  //baseURL: 'https://cloud.mmrlivingstone.com/thinkific-api',
})
```
- Run `npm run serve`
- Access the SPA at http://localhost:8080  
NOTE: The SPA will expect the API to be running on http://localhost:3000
### What did you not include in your solution that you want us to know about?
Other than the unit tests and OAuth authentication mentioned above, I don't believe there is anything.
### Other information about your submission that you feel it's important that we know if applicable.
N/A
### Your feedback on this technical challenge
Again, this has been the most fun I've had with a take home assignment yet!  
I very much appreciate the lack of purposefully vague requirements, as well as the lack of "gotcha" scenarios.