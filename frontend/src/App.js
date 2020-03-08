import React from "react";
import { BrowserRouter as Router, Switch, Route } from "react-router-dom";
import { Stats } from "./components/Stats/Stats";
import ApolloClient from "apollo-boost";
import { ApolloProvider } from "@apollo/react-hooks";
import { ThemeProvider } from "@material-ui/styles";

const apollo = new ApolloClient();

const App = () => {
  return (
    <ApolloProvider client={apollo}>
      <Router>
        <ThemeProvider>
          <Switch>
            <Route path="/">
              <Stats />
            </Route>
          </Switch>
        </ThemeProvider>
      </Router>
    </ApolloProvider>
  );
};

export default App;
