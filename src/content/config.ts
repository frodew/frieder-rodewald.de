import { defineCollection, z } from "astro:content";

const hexagonsCollection = defineCollection({
  type: "content",
  schema: z.object({
    title: z.string(),
    color: z.string(),
    order: z.number(),
  }),
});

const sectionsCollection = defineCollection({
  type: "content",
  schema: z.object({
    title: z.string(),
    sectionId: z.string(),
    navTitle: z.string().optional(),
    order: z.number(),
    color: z.string(),
  }),
});

export const collections = {
  hexagons: hexagonsCollection,
  sections: sectionsCollection,
};
