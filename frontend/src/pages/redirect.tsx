import { Center, Container, Loader, Stack, Text } from "@mantine/core"

export function RedirectPage() {
  const path = window.location.pathname
  console.log("pathhh", path)

  return (
    <Container>
      <Center>
        <Stack>
          <Center>
            <Loader />
          </Center>
          <Center>
            <Text fw={800}>Redirecting you to your url...</Text>
          </Center>
        </Stack>
      </Center>
    </Container>
  )
}
