import { useQuery } from "@tanstack/react-query"
import { slugsApi } from "features/slugs/services/slugs.api"

class SlugApiHooks {
  useSlugs = (query: any) => {
    return useQuery({
      queryKey: ["fetchSLugs", query],
      queryFn: () => slugsApi.getMany(query),
    })
  }
}

export const slugHooks = new SlugApiHooks()
