import {
  ActionIcon,
  Button,
  Center,
  Code,
  Container,
  Group,
  Stack,
  Text,
  TextInput,
  Title,
  Tooltip,
} from "@mantine/core"
import { IconCopy } from "@tabler/icons-react"
import axios from "axios"
import { useState } from "react"
import { COLORS } from "settings/app"

export function UrlShortenerPage() {
  const [url, setUrl] = useState("")
  const [shortenedUrl, setShortenedUrl] = useState("")
  const [error, setError] = useState("")

  async function submitUrl() {
    setError("")
    try {
      // Would normally set url to backend as an env var here
      const response = await axios.post("http://localhost:8080/api/slugs", {
        slug: {
          url: url,
        },
      })
      const slug = response.data?.data?.slug
      if (slug) {
        setShortenedUrl(`http://localhost:3000/${slug}`)
      }
    } catch (error: any) {
      console.error("error", error)
      setError(error?.response?.data?.message || error?.message)
      setShortenedUrl("")
    }
  }

  return (
    <Container w={"100%"}>
      <Stack>
        <Title c={COLORS.black}>URL Shortener</Title>
        <Text>Paste your url here:</Text>
        <Stack w={"100%"}>
          <TextInput
            placeholder="https://example.com"
            onChange={(event: any) => {
              setUrl(event.currentTarget.value)
            }}
            value={url}
            width={"100%"}
          />
          <Button onClick={submitUrl} fullWidth>
            Shorten
          </Button>
        </Stack>
        {shortenedUrl && (
          <Stack>
            <Text>Your shortened url is:</Text>
            <Group>
              <Code>
                <Center>
                  {shortenedUrl}{" "}
                  <Tooltip label="Copy to Clipboard">
                    <ActionIcon
                      variant="subtle"
                      onClick={() =>
                        navigator.clipboard.writeText(shortenedUrl)
                      }
                      ml={"xl"}
                    >
                      <IconCopy size={20} />
                    </ActionIcon>
                  </Tooltip>
                </Center>
              </Code>
            </Group>
          </Stack>
        )}
        {error && <Text color={"red"}>Uh oh: {error}</Text>}
      </Stack>
    </Container>
  )
}
