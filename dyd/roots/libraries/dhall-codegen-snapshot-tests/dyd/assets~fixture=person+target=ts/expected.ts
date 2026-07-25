export type Person =
	{
		appointment_time :
			/** RFC 3339 time */
			string;
		birth_date :
			/** ISO 8601 calendar date */
			string;
		created_at :
			/** RFC 3339 date-time */
			string;
		date_of_birth :
			/** date of birth */
			Date;
		friends :
			/** friends */
			Array<
				Person
			>;
		id :
			/** RFC 4122 UUID */
			string;
		name :
			/** full name */
			string;
		retention_period :
			/** ISO 8601 duration */
			string;
		contact_email ?:
			/** contact email (we might not have this) */
			string;
	};