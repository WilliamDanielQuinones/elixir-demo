import {
  Button,
  Container,
  Group,
  Stack,
  Text,
  TextInput,
  Title,
} from "@mantine/core"
import { useState } from "react"
import { COLORS } from "settings/app"

export function UrlShortenerPage() {
  const [url, setUrl] = useState("")
  const [shortenedUrl, setShortenedUrl] = useState("")

  async function submitUrl() {
    try {
      const response = await fetch("https://api.example.com/shorten", {})
      console.log("res", response)
    } catch (error) {
      console.error("error", error)
    }
  }

  return (
    <Container w={"100%"}>
      <Stack>
        <Title c={COLORS.black}>URL Shortener</Title>
        <Text>Paste your url here:</Text>
        <Group>
          <TextInput
            placeholder="https://example.com"
            onChange={(event: any) => {
              setUrl(event.currentTarget.value)
            }}
            value={url}
          />
          <Button onClick={submitUrl}>Shorten</Button>
        </Group>
        {shortenedUrl && <Text>Your shortened url is: {shortenedUrl}</Text>}
      </Stack>
    </Container>
  )
}
