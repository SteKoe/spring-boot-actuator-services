import ReactDOM from "react-dom";
import { App } from "./App";
import "./index.css"
import "bulma/css/bulma.min.css";
import "@fortawesome/fontawesome-free/js/all.min"

const app = document.getElementById("app");
ReactDOM.render(<App />, app);