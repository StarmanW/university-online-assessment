//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace university_online_assessment.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Enrollment
    {
        public int Id { get; set; }
        public System.Guid studId { get; set; }
        public System.Guid progId { get; set; }
        public System.DateTime enrollmentDateTime { get; set; }
    
        public virtual aspnet_Users aspnet_Users { get; set; }
        public virtual Programme Programme { get; set; }
    }
}
