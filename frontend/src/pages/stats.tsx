import {
  Button,
  Center,
  Container,
  Group,
  Loader,
  Stack,
  Table,
  Title,
} from "@mantine/core"
import { IconDownload } from "@tabler/icons-react"
import { slugHooks, slugsApi } from "features/slugs"

export function StatsPage() {
  const { data: elements, isLoading } = slugHooks.useSlugs({})

  if (isLoading) {
    return (
      <Center>
        <Loader />
      </Center>
    )
  }

  const rows = elements?.map((element) => (
    <Table.Tr key={element.id}>
      <Table.Td>{element.id}</Table.Td>
      <Table.Td>{element.url}</Table.Td>
      <Table.Td>{element.slug}</Table.Td>
      <Table.Td>{element.visited}</Table.Td>
    </Table.Tr>
  ))

  async function downloadCsv() {
    await slugsApi.export()
  }

  return (
    <Container w={"90%"}>
      <Stack>
        <Group justify={"space-between"}>
          <Title order={1}>Stats</Title>
          <Button onClick={downloadCsv}>
            <Group>
              <IconDownload />
              Download CSV
            </Group>
          </Button>
        </Group>
        <Table>
          <Table.Thead>
            <Table.Tr>
              <Table.Th>Id</Table.Th>
              <Table.Th>Url</Table.Th>
              <Table.Th>Slug</Table.Th>
              <Table.Th>Times Visited</Table.Th>
            </Table.Tr>
          </Table.Thead>
          <Table.Tbody>{rows}</Table.Tbody>
        </Table>
      </Stack>
    </Container>
  )
}
