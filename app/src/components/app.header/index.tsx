import { ActionIcon, Group, Image, Text, Tooltip } from "@mantine/core"
import Logo from "assets/logo.png"
import { IconBrandGithub, IconBrandLinkedin } from "@tabler/icons-react"

import "@mantine/core/styles.css"
import { COLORS } from "settings/app"

export function AppHeader() {
  return (
    <Group
      pl={32}
      pr={32}
      pt={16}
      pb={16}
      mb={24}
      styles={{
        root: {
          boxShadow:
            "0 0 0 1px rgba(64, 87, 109, .07), 0 2px 8px rgba(57, 76, 96, .15)",
        },
      }}
      justify="space-between"
    >
      <Group>
        <Image
          src={Logo}
          alt="demo logo"
          width={32}
          height={32}
          fallbackSrc="https://placehold.co/40x40"
        />

        <Text m={0} p={0} size="xl" fw={900} c={COLORS.blue}>
          URL Shortener
        </Text>
      </Group>
      <Group>
        <Tooltip label="Github" position="bottom">
          <ActionIcon
            variant="filled"
            aria-label="github"
            size={"lg"}
            onClick={() =>
              window.open("https://github.com/WilliamDanielQuinones", "_blank")
            }
          >
            <IconBrandGithub stroke={1.5} />
          </ActionIcon>
        </Tooltip>
        <Tooltip label="LinkedIn" position="bottom">
          <ActionIcon
            variant="filled"
            aria-label="github"
            size={"lg"}
            onClick={() =>
              window.open(
                "https://www.linkedin.com/in/william-quinones-4630338a/",
                "_blank"
              )
            }
          >
            <IconBrandLinkedin stroke={1.5} />
          </ActionIcon>
        </Tooltip>
      </Group>
    </Group>
  )
}
