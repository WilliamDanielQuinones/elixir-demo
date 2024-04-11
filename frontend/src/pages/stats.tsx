import { Center, Container, Loader, Table } from "@mantine/core"
import { slugHooks } from "features/slugs"

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
    console.log("hi")
  }

  return (
    <Container w={"90%"}>
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
    </Container>
  )
}
