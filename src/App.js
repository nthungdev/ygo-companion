import React from "react"
import logo from "./logo.svg"
import { HashRouter, Route } from "react-router-dom"
import PolicyPage from "pages/PolicyPage/PolicyPage"
import "./styles/tailwind.css"

function App() {
  return (
    <div className="App">
      <HashRouter>
        <Route exact path="/policy" component={PolicyPage} />
      </HashRouter>
    </div>
  )
}

export default App
