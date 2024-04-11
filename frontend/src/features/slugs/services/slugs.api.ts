import qs from "qs"
import { ISlug } from "features/slugs/types/slugs.types"
import axios from "axios"

class SlugsApiSingleTon {
  async getMany(rawQuery: any) {
    const query = qs.stringify(rawQuery)
    try {
      const response = await axios.get(
        "http://localhost:8080/api/slugs?" + query
      )
      return (response?.data?.data as ISlug[]) || []
    } catch (error) {
      console.log("error fetching slugs", error)
      return []
    }
  }

  // async getBySlug(slug: string) {
  //   try {
  //     const response = await axios.get("http://localhost:8080/api/slugs")
  //     return (response?.data?.data as ISlug) || []
  //   } catch (error) {
  //     console.log("error fetching slugs", error)
  //     return []
  //   }
  // }
}

export const slugsApi = new SlugsApiSingleTon()
