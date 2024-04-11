import { AppWrapper } from "layouts"
import { UrlShortenerPage } from "pages"
import {
  Navigate,
  Outlet,
  Route,
  RouterProvider,
  createBrowserRouter,
  createRoutesFromElements,
} from "react-router-dom"

export function AppRoutes() {
  function renderAllRoutes() {
    return (
      <Route
        element={<AppWrapper />}
        errorElement={<div>There's been an error!</div>}
      >
        <Route path={"/"} element={<Outlet />}>
          <Route index element={<UrlShortenerPage />} />
        </Route>
        <Route index element={<Navigate to={"/"} />} />
        <Route path={"*"} element={<Navigate to={"/"} />} />
      </Route>
    )
  }

  const router = createBrowserRouter(
    createRoutesFromElements(renderAllRoutes())
  )

  return <RouterProvider router={router} />
}

export default AppRoutes
