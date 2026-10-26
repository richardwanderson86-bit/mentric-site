import { defineCollection, z } from 'astro:content';

const blog = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string(),
    date: z.date(),
    category: z.string(),
    author: z.string().optional(),
  }),
});

const podcast = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string(),
    date: z.date(),
    draft: z.boolean().optional(),
    episodeNumber: z.number().optional(),
    duration: z.string().optional(),
    guest: z.string().optional(),
    spotifyUrl: z.string().url().optional(),
    appleUrl: z.string().url().optional(),
    youtubeUrl: z.string().url().optional(),
  }),
});

export const collections = { blog, podcast };
