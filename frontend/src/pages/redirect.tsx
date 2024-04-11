import { Center, Container, Loader, Stack, Text } from "@mantine/core"
import { slugHooks } from "features/slugs"
import { useEffect } from "react"

export function RedirectPage() {
  const path = window.location.pathname
  const slug = path.replace("/", "")

  const { data: slugData, isLoading } = slugHooks.useSlugBySlug(slug)
  const { mutateAsync: updateSlug } = slugHooks.useUpdate()

  useEffect(() => {
    if (!isLoading && slugData) {
      const resp = updateSlug({
        id: slugData.id,
        visited: slugData.visited + 1,
      })
      resp.then(() => {
        window.location.href = slugData?.url
      })
    }
  }, [slugData, updateSlug])

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
