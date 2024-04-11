import { Stack } from "@mantine/core";
import { Outlet } from "react-router-dom";
import { COLORS } from "settings/app";

import "@mantine/core/styles.css";
import { AppHeader } from "components";

export function AppWrapper() {
  return (
    <div
      style={{
        backgroundColor: COLORS.background,
        backgroundImage: `linear-gradient(${COLORS.background}, ${COLORS.white})`,
        width: "100%",
        height: "100vh",
      }}
    >
      <Stack gap={0}>
        <AppHeader />
        <Outlet />
      </Stack>
    </div>
  );
}
