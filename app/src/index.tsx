import React from "react";
import ReactDOM from "react-dom/client";
import "./index.css";
import reportWebVitals from "./reportWebVitals";
import { MantineProvider, createTheme } from "@mantine/core";
import { AppRoutes } from "routes";
import { QueryClientProvider } from "@tanstack/react-query";
import { queryClient } from "settings";

const root = ReactDOM.createRoot(
  document.getElementById("root") as HTMLElement
);

const theme = createTheme({});

function Entrypoint() {
  return (
    <MantineProvider theme={theme}>
      <QueryClientProvider client={queryClient}>
        <AppRoutes />
      </QueryClientProvider>
    </MantineProvider>
  );
}

root.render(<Entrypoint />);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
