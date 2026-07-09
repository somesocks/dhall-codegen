export type Person =
	{
		date_of_birth :
			/** date of birth */
			Date;
		friends :
			/** friends */
			Array<
				Person
			>;
		name :
			/** full name */
			string;
		contact_email ?:
			/** contact email (we might not have this) */
			string;
	};
