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

  async getBySlug(slug: string) {
    try {
      const response = await axios.get(
        "http://localhost:8080/api/slugs/" + slug
      )
      return (response?.data?.data as ISlug) || undefined
    } catch (error) {
      console.log("error fetching slug", error)
      return undefined
    }
  }

  async update(id: string, values: Partial<ISlug>) {
    try {
      const response = await axios.put(
        "http://localhost:8080/api/slugs/" + id,
        {
          slug: {
            ...values,
          },
        }
      )
      return (response?.data?.data as ISlug) || undefined
    } catch (error) {
      console.log("error updating slug", error)
      return undefined
    }
  }

  async export() {
    try {
      const response = await axios.get("http://localhost:8080/api/slugs/export")
      const url = window.URL.createObjectURL(new Blob([response.data]))
      const link = document.createElement("a")
      link.href = url
      link.setAttribute("download", "slug-export.csv")
      document.body.appendChild(link)
      link.click()
      link.remove()
    } catch (error) {
      console.log("error exporting slugs", error)
    }
  }
}

export const slugsApi = new SlugsApiSingleTon()
