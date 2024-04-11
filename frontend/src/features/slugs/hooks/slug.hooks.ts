import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query"
import { slugsApi } from "features/slugs/services/slugs.api"
import { ISlug } from "../types/slugs.types"

class SlugApiHooks {
  useSlugs = (query: any) => {
    return useQuery({
      queryKey: ["fetchSlugs", query],
      queryFn: () => slugsApi.getMany(query),
    })
  }

  useSlugBySlug = (slug: string) => {
    return useQuery({
      queryKey: ["fetchSlug", slug],
      queryFn: () => slugsApi.getBySlug(slug),
    })
  }

  useUpdate = () => {
    const queryClient = useQueryClient()
    return useMutation({
      mutationFn: (payload: any) => {
        const id = payload.id
        delete payload.id
        return slugsApi.update(id, payload)
      },
      onSuccess: async (data: any) => {
        await queryClient.invalidateQueries({
          queryKey: ["fetchSlug", data?.data],
        })
        await queryClient.invalidateQueries({
          queryKey: ["fetchSlugs"],
        })
      },
    })
  }
}

export const slugHooks = new SlugApiHooks()
