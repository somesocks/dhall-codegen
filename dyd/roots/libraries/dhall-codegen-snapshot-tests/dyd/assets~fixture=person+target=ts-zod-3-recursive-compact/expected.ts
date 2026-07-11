

import { z } from 'zod';

export type TPerson = { date_of_birth : /** date of birth */ Date; friends : /** friends */ Array< TPerson >; name : /** full name */ string; contact_email ?: /** contact email (we might not have this) */ string; };

export const Person : z.ZodType<TPerson> = z.lazy(() =>  z.object({ date_of_birth : z.date().describe("date of birth"), friends : z.array( Person ).describe("friends"), name : z.string().describe("full name"), contact_email : z.string().email().describe("contact email (we might not have this)").optional(), }));
