This is an LTI app that allows embedding arbitrary links in Canvas navigation. There is a basic form for generating the XML config, which allows a user to input the URL of the site to embed and where in Canvas the nav item should appear (account, course, user nav).

Once the added nav item is triggered from Canvas, it makes a POST request back to the app, passing along the custom URL from the configuration. The app simply redirects to this URL. As long as the X-Frame-Options on the target site are set to allow embedding, it will be rendered in the Canvas iframe.
